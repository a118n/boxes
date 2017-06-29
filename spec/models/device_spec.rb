require 'rails_helper'

RSpec.describe Device, type: :model do

  before { build(:site) }

  describe "Factory" do
    it "has a valid factory" do
      expect(build(:device)).to be_valid
    end
  end

  describe "Associations" do
    it { should belong_to :site }
    it { should have_many :device_supplies }
    it { should have_many(:supplies).through(:device_supplies) }
  end

  describe "Validations" do
    context "valid data" do
      it { should validate_presence_of :name }
      it { should validate_presence_of :devtype }
      it { should validate_presence_of :status }
      # Seems like scoped_to is bugged, see: https://github.com/thoughtbot/shoulda-matchers/issues/814
      xit { should validate_uniqueness_of(:name).case_insensitive.scoped_to(:site) }
    end

    context "invalid data" do
      it "is not valid without a name" do
        expect(build(:device, name: nil)).not_to be_valid
      end
      it "is not valid without a type" do
        expect(build(:device, devtype: nil)).not_to be_valid
      end
      it "is not valid without a status" do
        expect(build(:device, status: nil)).not_to be_valid
      end
    end
  end
end
