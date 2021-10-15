require 'rails_helper'

describe Movie do
    describe 'Movie.movies_with_same_director' do

        let!(:movie1) { FactoryGirl.create(:movie, title: 'Inception', director: 'Christopher Nolan') }
        let!(:movie2) { FactoryGirl.create(:movie, title: 'Tenet', director: 'Christopher Nolan') }
        let!(:movie3) { FactoryGirl.create(:movie, title: 'Batman Begins', director: 'Christopher Nolan') }
        let!(:movie4) { FactoryGirl.create(:movie, title: 'Dunkirk', director: 'Christopher Nolan') }
        let!(:movie5) { FactoryGirl.create(:movie, title: 'Gone Girl', director: 'David Fincher') }
        let!(:movie6) { FactoryGirl.create(:movie, title: 'Fight Club', director: 'David Fincher') }
        let!(:movie7) { FactoryGirl.create(:movie, title: 'Dune', director: 'Denis Villeneuve') }
        let!(:movie8) { FactoryGirl.create(:movie, title: 'Mad Max', director: '') }
        
        it 'finds similar movies' do
            movie1SimilarsList = []
            movie5SimilarsList = []
            movie7SimilarsList = []
            
            movie1Similars = Movie.movies_with_same_director(movie1.title)
            movie5Similars = Movie.movies_with_same_director(movie5.title)
            movie7Similars = Movie.movies_with_same_director(movie7.title)
            
            movie1Similars.each do |x|
                movie1SimilarsList.append(x.title)
            end
            movie5Similars.each do |x|
                movie5SimilarsList.append(x.title)
            end
            movie7Similars.each do |x|
                movie7SimilarsList.append(x.title)
            end
            
            expect(movie1SimilarsList).to eql(['Tenet', 'Batman Begins', 'Dunkirk'])
            expect(movie5SimilarsList).to eql(['Fight Club'])
            expect(movie7SimilarsList).to eql([])
        end
        
        it 'doesn\'t find unsimilar movies' do
            movie1SimilarsList = []
            movie5SimilarsList = []
            movie7SimilarsList = []
            
            movie1Similars = Movie.movies_with_same_director(movie1.title)
            movie5Similars = Movie.movies_with_same_director(movie5.title)
            movie7Similars = Movie.movies_with_same_director(movie7.title)
            
            movie1Similars.each do |x|
                movie1SimilarsList.append(x.title)
            end
            movie5Similars.each do |x|
                movie5SimilarsList.append(x.title)
            end
            movie7Similars.each do |x|
                movie7SimilarsList.append(x.title)
            end
            
            expect(movie1SimilarsList).to_not include(['Gone Girl', 'Fight Club', 'Dune'])
            expect(movie5SimilarsList).to_not include(['Tenet', 'Batman Begins', 'Dunkirk', 'Dune'])
            expect(movie7SimilarsList).to_not include(['Tenet', 'Batman Begins', 'Dunkirk', 'Gone Girl', 'Fight Club'])
        end
        
        it 'returns empty list when no director is found' do
            expect(Movie.movies_with_same_director(movie8.title)).to eql([])
        end
        
    end
end