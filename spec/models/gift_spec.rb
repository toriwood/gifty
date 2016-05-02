describe Gift do 

  before(:each) { @gift = Gift.new(wishlist_id: 1, url: 'https://www.example.com') }
  
  it "should be valid" do
    expect(@gift).to be_valid
  end

  it "should reject a bad url" do
    @gift.update_attributes(url: "ftp://website.com")
    expect(@gift).to_not be_valid
  end

  it "should reject a blank url" do
    @gift.update_attributes(url: "")
    expect(@gift).to_not be_valid
  end
end