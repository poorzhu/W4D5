require 'rails_helper'

RSpec.describe User, type: :model do

  subject(:user) { User.new(username: 'example', password: 'password') }

  describe 'validations' do
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:password_digest) }
    it { should validate_presence_of(:session_token) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end
  
  describe 'associations' do
    it { should have_many(:goals) }
  end

  describe 'User#ensure_session_token' do
    it 'should make user.session_token not nil' do
      expect(user.session_token).to be_truthy
    end
  end

  describe "User#password" do
    it "should return the user's password" do
      expect(user.password).to eq('password')
    end
  end

  describe "User#password=(password)" do
    it 'sets password instance variable equal to input' do
      expect(user.password).to eq('password')
    end

    context 'sets the password_digest to the hashed password' do 
      it { should ensure_length_of(:password_digest).is_equal_to(22) }
    end

    it 'fails if password has less than a length of 6' do
      old_password = user.password
      user.password = 'abc'
      expect{ user.save! }.to raise_error
    end
  end

  describe "User#reset_session_token!" do
    it "should reset users's session token" do
      old_session_token = user.session_token
      user.reset_session_token!
      expect(user.session_token).to_not eq(old_session_token)
    end

    it "should return the session token that was set to the user" do
      new_session_token = user.reset_session_token!
      expect(user.session_token).to eq(new_session_token)
    end
  end

  describe "User::find_by_credentials(username, password" do
    it "should return appropriate user object" do
      user2 = User.new(username: 'example2', password: 'password')
      user2.save
      expect(User.find_by_credentials('example2', 'password')).to be(user2)
    end

    it "should return nil if no matches are found" do
      expect(User.find_by_credentials('example420', 'password')).to be_nil
    end    
  end

  describe "User#is_password?(password)" do
    it "should return true if password is correct" do
      expect(user.is_password?('password')).to be true
    end

    it "should return true if password is correct" do
      expect(user.is_password?('password420')).to be false
    end   
  end
end

# done

# validations password length: { minumum: 6, allow_nil: true} 
# validates presence: true for session_token, password_digest, session_token
# ensure_session_token
# adter_intialization :ensure_session_token
# password=(password)
# attr_reader :password
# reset_session_token!
# self.find_by_credentials(username, password)
# is_password?(password)

#to-do

# user_has_many :goals

