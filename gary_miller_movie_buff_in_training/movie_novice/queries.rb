# == Schema Information
#
# Table name: actors
#
#  id          :integer      not null, primary key
#  name        :string
#
# Table name: movies
#
#  id          :integer      not null, primary key
#  title       :string
#  yr          :integer
#  score       :float
#  votes       :integer
#  director_id :integer
#
# Table name: castings
#  id          :integer      not null, primary key
#  movie_id    :integer      not null
#  actor_id    :integer      not null
#  ord         :integer


def find_angelina
  #find Angelina Jolie by name in the actors table
  angy = Actor.where( 'name = ?', 'Angelina Jolie' )
  return angy[0]
end

def top_titles
  # get movie titles from movies with scores greater than or equal to 9
  # hint: use 'select' and 'where'
  movies = Movie
    .find_by_sql([
      'SELECT title, id FROM movies WHERE score >= 9'
    ])
  return movies
end

def star_wars
  #display the id, title and year of each Star Wars movie in movies.
  # hint: use 'select' and 'where'
  movies = Movie
                .select('id, title, yr')
  return movies.select { |movie| movie.title.include?("Star Wars") }
end


def below_average_years
  #display each year with movies scoring under 5,
  #with the count of movies scoring under 5 aliased as bad_movies,
  #in descending order
  # hint: use 'select', 'where', 'group', 'order'
  bad_years = Movie
                .select('yr, COUNT(*) AS bad_movies')
                .where('score < ?', 5)
                .group('yr')
                .order('yr DESC')
end

def alphabetized_actors
  # display the first 10 actor names ordered from A-Z
  # hint: use 'order' and 'limit'
  # Note: Ubuntu users may find that special characters
  # are alphabetized differently than the specs.
  # This spec might fail for Ubuntu users. It's ok!
  first_ten = Actor
              .select('id, name')
              .order('name')
              .limit(10)
end

def pulp_fiction_actors
  # practice using joins
  # display the id and name of all actors in the movie Pulp Fiction
  # hint: use 'select', 'joins', 'where'
  Actor
    .select('actors.id, name')
    .joins(:movies)
    .where('title = ?', 'Pulp Fiction')
end

def uma_movies
  #practice using joins
  # display the id, title, and year of movies Uma Thurman has acted in
  # order them by ascending year
  # hint: use 'select', 'joins', 'where', and 'order'
  Movie
    .select('movies.id, title, yr')
    .joins(:actors)
    .where('name = ?', 'Uma Thurman')
    .order('yr ASC')
end
