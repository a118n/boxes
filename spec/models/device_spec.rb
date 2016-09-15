require 'rails_helper'

RSpec.describe Device, type: :model do

  before { create(:site) }

  it "should have a valid factory" do
    expect(build(:device)).to be_valid    
  end

  describe "Associations" do
    it { should belong_to :site }
    it { should have_many :device_supplies }
    it { should have_many(:supplies).through(:device_supplies) }
  end

  describe "Validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :devtype }
    it { should validate_presence_of :state }
    it { should validate_uniqueness_of(:name).case_insensitive }
    it "should not be valid without a name" do
      expect(build(:device, name: nil)).not_to be_valid
    end
    it "should not be valid without a type" do
      expect(build(:device, devtype: nil)).not_to be_valid
    end
    it "should not be valid without a state" do
      expect(build(:device, state: nil)).not_to be_valid
    end
  end
end
