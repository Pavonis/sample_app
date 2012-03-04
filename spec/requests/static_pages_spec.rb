require 'spec_helper'

describe "Static pages" do
    
    subject { page }
    
    shared_examples_for "all static pages" do
        it{ should have_selector('h1', text: heading) }
        it{ should have_selector('title', text: full_title(title)) }
    end
    
    describe "Home page" do
        before { visit root_path }
        
        let(:heading) { 'Sample App' }
        let(:title) { 'Home' }
        
        it_should_behave_like "all static pages"
    end
    
    describe "Help page" do
        before { visit help_path }
        
        let(:heading) { 'Help' }
        let(:title) { 'Help' }
        
        it_should_behave_like "all static pages"
    end
    
    describe "About page" do
        before { visit about_path }
        
        let(:heading) { 'About' }
        let(:title) { 'About Us' }
        
        it_should_behave_like "all static pages"
    end
    
    describe "Contact page" do
        before { visit contact_path }
        
        let(:heading) { 'Contact' }
        let(:title) { 'Contact' }
        
        it_should_behave_like "all static pages"
    end
end