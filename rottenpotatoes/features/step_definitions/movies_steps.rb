
Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    Movie.create movie
  end
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  expect(page.body.index(e1) < page.body.index(e2))
end

When /I (un)?check the following ratings: (.*)/ do |uncheck, rating_list|
  rating_list.split(', ').each do |rating|
    step %{I #{uncheck.nil? ? '' : 'un'}check "ratings_#{rating}"}
  end
end

Then /I should see all the movies/ do
  Movie.all.each do |movie|
    step %{I should see "#{movie.title}"}
  end
end

Then /the director of "(.*)" should be "(.*)"/ do |movie_name, director_name|
  selected_movie = Movie.where(title: movie_name).first
  expect(selected_movie.director).to match(director_name)
end