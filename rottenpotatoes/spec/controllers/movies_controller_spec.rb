require 'rails_helper'

describe MoviesController do
    
    describe 'get show action' do
        
        let!(:movie) { MovieFactory.create(:movie) }
        before(:each) do
            get :show, id: movie.id
        end
        
        it 'should find the movie' do
            expect(assigns(:movie)).to eql(movie)
        end
        
        it 'should render the show template' do
            expect(response).to render_template('show')
        end
        
    end
    
    
end