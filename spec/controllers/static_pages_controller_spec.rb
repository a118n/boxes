require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do
  describe "Get views" do
      it "renders the :home view" do
        get :home
      end
      it "renders the :about view" do
        get :about
      end
      it "renders the :overview view" do
        get :overview
      end
    end
end
