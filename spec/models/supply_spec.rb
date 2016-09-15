require 'rails_helper'

RSpec.describe Supply, type: :model do

  before { create(:site) }

  it "has a valid factory" do
    expect(build(:supply)).to be_valid
  end

  describe "Associations" do
    it { should belong_to :site }
    it { should have_many :device_supplies }
    it { should have_many(:devices).through(:device_supplies) }
  end

  describe "Validations" do
    context "valid data" do
      it { should validate_presence_of :name }
      it { should validate_presence_of :quantity }
      it { should validate_presence_of :threshold }
      it { should validate_numericality_of :quantity }
      it { should validate_numericality_of :threshold }
    end

    context "invalid data" do
      it "is not valid without a name" do
        expect(build(:supply, name: nil)).not_to be_valid
      end
      it "is not valid without a quantity" do
        expect(build(:supply, quantity: nil)).not_to be_valid
      end
      it "is not valid without a threshold" do
        expect(build(:supply, threshold: nil)).not_to be_valid
      end
    end
  end
end
