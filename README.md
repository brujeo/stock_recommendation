# stock_recommendation

A ruby gem that retrieves buy | sell | hold recommendations for the stock from Reuters Analyst Website

## Installation

To install the 'stock_recommendation' ruby gem:

`gem install stock_recommendation`

## Gem Configuration

To use the gem in your Rails Application, include it in your Gemfile:

`gem "stock_recommendation"`, '~> 0.0.1'

### StockRecommendation::Recommendation.get(symbol)

Get is the primary method, returning a StockRecommendation::Recommendation instance, including the following attributes

`title, consensus_recommendation, date_updated, votes_buy, votes_buy_one_month_ago, votes_buy_two_months_ago, votes_buy_three_months_ago, votes_outperform, votes_outperform_one_month_ago, votes_outperform_two_months_ago, votes_outperform_three_month_ago,votes_hold, votes_hold_one_month_ago, votes_hold_two_months_ago, votes_hold_three_months_ago, votes_underperform, votes_underperform_one_month_ago,votes_underperform_two_months_ago, votes_underperform_three_months_ago, votes_sell, votes_sell_one_month_ago, votes_sell_two_months_ago, votes_sell_three_months_ago,votes_no_opinion, votes_no_opinion_one_month_ago, votes_no_opinion_two_months_ago, votes_no_opinion_three_months_ago`

Most importnat field gere is `consensus_recommendation`, that can contain 5 possible analyst ratings:
  - buy             (Strong Buy)
  - outperform      (Moderate Buy, Accumulate, Over-Weight Add)
  - hold            (Neutral)
  - underperform    (moderate sell, weak hold, Underweight reduce)
  - sell            (Strong Sell)

  You can read more about Analyst Ratings here
  https://www.investopedia.com/financial-edge/0512/understanding-analyst-ratings.aspx#mntl-sc-block_1-0-2



You can receive a raw json hash response with the following syntax:

`StockRecommendation::Recommendation.get_json("AAPL)
