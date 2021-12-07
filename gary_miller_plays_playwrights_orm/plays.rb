require 'sqlite3'
require 'singleton'

class PlayDBConnection < SQLite3::Database
  include Singleton

  def initialize
    super('plays.db')
    self.type_translation = true
    self.results_as_hash = true
  end
end

class Play
  attr_accessor :id, :title, :year, :playwright_id

  def self.all
    data = PlayDBConnection.instance.execute("SELECT * FROM plays")
    data.map { |datum| Play.new(datum) }
  end

  def self.find_by_title(title)
    play = PlayDBConnection.instance.execute(<<-SQL, self.title)
      SELECT
        *
      FROM
        plays
      WHERE
        title = ?
    SQL
    return nil if play.count < 1
    return Play.new(play.first)
  end

  def self.find_by_playwright(name)
    playwright = PlayDBConnection.instance.execute(<<-SQL, self.name )
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = playwright.name
    SQL
    return nil if playwright.count < 1
    return Playwright.new
  end

  def initialize(options)
    @id = options['id']
    @title = options['title']
    @year = options['year']
    @playwright_id = options['playwright_id']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id)
      INSERT INTO
        plays (title, year, playwright_id)
      VALUES
        (?, ?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL, self.title, self.year, self.playwright_id, self.id)
      UPDATE
        plays
      SET
        title = ?, year = ?, playwright_id = ?
      WHERE
        id = ?
    SQL
  end

end

class Playwright

  def self.all
    data = PlayDBConnection.instance.execute(SELECT * FROM playwrights)
    data.map { |datum| Playwright.new(datum) }
  end

  def self.find_by_name(name)
    playwright = PlayDBConnection.instance.execute(<<-SQL, self.name )
      SELECT
        *
      FROM
        playwrights
      WHERE
        name = playwright.name
    SQL
    return nil if playwright.count < 1
    return Playwright.new
  end

  def initialize(options)
    @id = options['id']
    @name = options['name']
    @birth_year = options['birth_year']
  end

  def create
    raise "#{self} already in database" if self.id
    PlayDBConnection.instance.execute(<<-SQL self.name, self.birth_year)
    INSERT INTO
      playwrights (name, birth_year)
    VALUES
      (?, ?)
    SQL
    self.id = PlayDBConnection.instance.last_insert_row_id
  end

  def update
    raise "#{self} not in database" unless self.id
    PlayDBConnection.instance.execute(<<-SQL self.name, self.birth_year, self.id)
    UPDATE
      playwrights
    SET
      name = ?, birth_year = ?
    WHERE
      id = ?
    SQL
  end

  def get_plays(name) # (returns all plays written by playwright)
    plays = PlayDBConnection.instance.execute(<<-SQL self.name)
    SELECT
      *
    FROM
      playwrights
    WHERE
      name = ?
    SQL
      return plays
  end

end