require 'spec_helper'

describe "StaticPages" do

    describe "Home page" do
        it "should have the content 'Sample App'" do
            visit '/static_pages/home'
            page.should have_content('Sample App')
        end
    end
    
    describe "Help Page" do
        it "should have the content 'help'" do
            visit '/static_pages/help'
            page.should have_content('Help')
        end
    end
    
    describe "About Us" do
        it "should have the content 'about us'" do
            visit '/static_pages/about'
            page.should have_content('About Us')
        end
    end
end
