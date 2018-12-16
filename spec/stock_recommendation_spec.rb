require 'stock_recommendation'
require 'spec_helper'

describe StockRecommendation::Recommendation do
  
  describe '#query' do
    describe 'single symbol string' do
      it "should be instance of Stock" do
        @recommendation = StockRecommendation::Recommendation.get('aapl')
        expectation(@recommendation)
      end
      it "should be hash" do
        @recommendation = StockRecommendation::Recommendation.get('aapl')
        expectation(@recommendation.to_hash, 'hash')
      end
    end
  end

  protected
  
  def expectation(recommendation, fmt=nil)
    if fmt=='hash'
      expect(recommendation).to be_an_instance_of(Hash)
    else
      expect(recommendation).to be_an_instance_of(StockRecommendation::Recommendation)
      expect(recommendation).to respond_to(:title)
      expect(recommendation).to respond_to(:consensus_recommendation)
    end
  end
end