require 'spec_helper'

describe "UserPages" do
  
  subject { page }
  
  describe "signup page" do
        before { visit signup_path }
        
        it { should have_selector('h1',     text: 'Sign Up') }
        it { should have_selector('title', text: full_title('Sign Up')) };
    end
    
    describe "user profile page" do
    
        let(:user)  { FactoryGirl.create(:user) }
        before { visit user_path(user) }
        
        it { should have_selector('h1', text: user.name) }
        it { should have_selector('title', text: user.name) }
    end
    
    describe "signup process" do
        before { visit signup_path }
        
        describe "with invalid information" do
            it "should not create a user" do
                expect { click_button "Sign Up" }.not_to change(User, :count)
            end
        end
        
        describe "with valid information" do
            before do
                fill_in "Name",         with: "Example User"
                fill_in "Email",        with: "mail@example.com"
                fill_in "Password",     with: "foobar"
                fill_in "Confirmation", with: "foobar"
            end
            
            it "should create a user" do
                expect { click_button "Sign Up" }.to change(User, :count).by(1)
            end
            
            describe "upon saving the user" do
                before { click_button "Sign Up" }
                let(:user) { User.find_by_email('mail@example.com') }

                it { should have_selector('title', text: user.name) }
                it { should have_selector('div.flash.success', text: 'Welcome') }
                it { should have_link('Sign Out', href: '/signout') }
                
                describe "upon logging out" do
                    before { click_link "Sign Out" }
                    it { should have_link('Sign In') }
                end
            end
        end
    end
end
