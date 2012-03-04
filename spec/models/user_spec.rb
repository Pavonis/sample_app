require 'spec_helper'

describe User do
  
    before do
        @user = User.new(name: "Example User", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    end
    
    subject { @user }
    
    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:authenticate) }
    
    it {should be_valid }
    
    # Name Validation
    describe "should require a name" do
        before { @user.name = " " }
        it { should_not be_valid }
    end
    
    describe "should not have an overly long name" do
        long_name = "a" * 51
        before { @user.name = long_name }
        it { should_not be_valid }
    end
    
    # Email Validation
    describe "should require an email" do
        before { @user.email = " " }
        it { should_not be_valid }
    end
    
    describe "should accept valid emails" do
        addresses = %w[user@foo.com, THE_USER@foo.bar.org, last.firs@user.jp]
        addresses.each do |address|
            before { @user.email = address }
            it { should be_valid }
        end
    end
    
    describe "should reject invalid addresses" do
        addresses = %w[user@foo,com, user_at_foo.org, example@foo.]
        addresses.each do |address|
            before { @user.email = address }
            it { should_not be_valid }
        end
    end
    
    describe "should be a unique address" do
        before do
            user_with_same_email = @user.dup
            user_with_same_email.email = @user.email.upcase
            user_with_same_email.save
        end
        
        it { should_not be_valid }
    end
    
    #Password Validation
    describe "password should not be blank" do
        before { @user.password = @user.password_confirmation = " " }
        it { should_not be_valid }
    end
    
    describe "should not accept a short password" do
        before { @user.password = @user.password_confirmation = "a" * 5 }
        it { should_not be_valid }
    end
    
    describe "should not mismatch confirmation" do
        before { @user.password_confirmation = "mismatch" }
        it { should_not be_valid }
    end
    
    describe "should respond to authenticate correctly" do
        before { @user.save }
        let(:found_user) { User.find_by_email(@user.email) } 
        
        describe "should accept correct password" do
            it { should == found_user.authenticate(@user.password) }
        end
        
        describe "should reject invalid password" do
            let(:user_invalid_password)  { found_user.authenticate("invalid") }
            
            it { should_not == user_invalid_password }
            specify { user_invalid_password.should be_false }
        end
    end
end
