require 'rails_helper'

RSpec.describe JwtDenylist, type: :model do
  describe "table name" do
    it "uses the correct table name" do
      expect(JwtDenylist.table_name).to eq('jwt_denylist')
    end
  end

  describe "Devise JWT Revocation Strategy" do
    it "includes Devise::JWT::RevocationStrategies::Denylist" do
      expect(JwtDenylist.ancestors).to include(Devise::JWT::RevocationStrategies::Denylist)
    end
  end
end