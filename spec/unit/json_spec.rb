RSpec.describe Mysqlexport::Json do
  let(:options) { DB_INFO.clone }
  it "can create json object" do
    expect(Mysqlexport::Json.new(options).class).to eq(::Mysqlexport::Json)
  end
end
