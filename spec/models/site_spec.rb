require 'rails_helper'

RSpec.describe Site, type: :model do

  describe "Factory" do
    it "has a valid factory" do
      expect(build(:site)).to be_valid
    end
  end

  describe "Associations" do
    it { should have_many :devices }
    it { should have_many :supplies }
  end

  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it "is not valid without a name" do
      expect(build(:site, name: nil)).not_to be_valid
    end
  end
end
