require 'rubygems'
require 'json'
require 'open-uri'
require 'nokogiri'

module StockRecommendation
  class Recommendation
    def self.get(stock_code)
      result = get_stock_recommendation(stock_code)
      Recommendation.new(result)
    end

    def self.get_json(stock_code)
      result = get_stock_recommendation(stock_code)
      result.to_json
    end

    protected
    
    def initialize(data={})
      data.each {|k,v|
        self.class.__send__(:attr_accessor, k.to_sym)
        self.instance_variable_set("@#{k}".to_sym, v)
      }
      @response_code = !!([{}, nil, ''].include?(data)) ? 500 :  200
    end

    def self.get_stock_recommendation(stock_code)
      document = fetch_recommendation(stock_code)
      recommendations = extract_recommendation(document)
    end

    def self.fetch_recommendation(stock_code)
      uri = 'https://www.reuters.com/finance/stocks/analyst/'
      response = open(uri + stock_code)
      @doc = Nokogiri::HTML(response);
      raise "Unable to fetch recommendations data for stock {#{stock_code}}" if !@doc.at_css("#sectionTitle > h1")
    end

    def self.extract_recommendation(document)
      recommendations = {}
      modules = @doc.xpath('//div[@class="module"]')
      recommendations["title"] = @doc.css("#sectionTitle > h1").text()
      modules.each do |m|
        if m.css("div.moduleHeader > h3").text().strip! == 'Consensus Recommendations'
          recommendations["consensus_recommendation"] = m.css("div.moduleBody > table > tbody > tr.stripe > td:nth-child(1)").text()
          recommendations["date_updated"] = m.css("div.moduleBody > table > tbody > tr.stripe > td:nth-child(4)").text()
        elsif m.css("div.moduleHeader > h3").text().strip! == 'Analyst Recommendations and Revisions'
          rows = m.css("div.moduleBody > table > tbody > tr")
          rows.each do |row|
            if row.css("td:nth-child(1)").text().include? "BUY"
              recommendations["votes_buy"] = row.css("td:nth-child(2)").text().to_i
              recommendations["votes_buy_one_month_ago"] = row.css("td:nth-child(3)").text().to_i
              recommendations["votes_buy_two_months_ago"] = row.css("td:nth-child(4)").text().to_i
              recommendations["votes_buy_three_months_ago"] = row.css("td:nth-child(5)").text().to_i
            elsif row.css("td:nth-child(1)").text().include? "SELL"
              recommendations["votes_sell"] = row.css("td:nth-child(2)").text().to_i
              recommendations["votes_sell_one_month_ago"] = row.css("td:nth-child(3)").text().to_i
              recommendations["votes_sell_two_months_ago"] = row.css("td:nth-child(4)").text().to_i
              recommendations["votes_sell_three_months_ago"] = row.css("td:nth-child(5)").text().to_i
            elsif row.css("td:nth-child(1)").text().include? "HOLD"
              recommendations["votes_hold"] = row.css("td:nth-child(2)").text().to_i
              recommendations["votes_hold_one_month_ago"] = row.css("td:nth-child(3)").text().to_i
              recommendations["votes_hold_two_months_ago"] = row.css("td:nth-child(4)").text().to_i
              recommendations["votes_hold_three_months_ago"] = row.css("td:nth-child(5)").text().to_i
            elsif row.css("td:nth-child(1)").text().include? "OUTPERFORM"
              recommendations["votes_outperform"] = row.css("td:nth-child(2)").text().to_i
              recommendations["votes_outperform_one_month_ago"] = row.css("td:nth-child(3)").text().to_i
              recommendations["votes_outperform_two_months_ago"] = row.css("td:nth-child(4)").text().to_i
              recommendations["votes_outperform_three_month_ago"] = row.css("td:nth-child(5)").text().to_i
            elsif row.css("td:nth-child(1)").text().include? "UNDERPERFORM"
              recommendations["votes_underperform"] = row.css("td:nth-child(2)").text().to_i
              recommendations["votes_underperform_one_month_ago"] = row.css("td:nth-child(3)").text().to_i
              recommendations["votes_underperform_two_months_ago"] = row.css("td:nth-child(4)").text().to_i
              recommendations["votes_underperform_three_months_ago"] = row.css("td:nth-child(5)").text().to_i
            elsif row.css("td:nth-child(1)").text().include? "No Opinion"
              recommendations["votes_no_opinion"] = row.css("td:nth-child(2)").text().to_i
              recommendations["votes_no_opinion_one_month_ago"] = row.css("td:nth-child(3)").text().to_i
              recommendations["votes_no_opinion_two_months_ago"] = row.css("td:nth-child(4)").text().to_i
              recommendations["votes_no_opinion_three_months_ago"] = row.css("td:nth-child(5)").text().to_i
            end
          end
        end
      end
      recommendations
    end

  end
end