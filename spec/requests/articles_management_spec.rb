# frozen_string_literal: true

require 'rails_helper'

describe 'Article Management' do
  context 'show' do
    it 'should render an article correctly' do
      article = create(:article)

      get api_v1_article_path(article)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to have_http_status(:ok)
      expect(json[:data][:title]).to eq(article.title)
      expect(json[:data][:body]).to eq(article.body)
    end

    it 'article not found' do
      get api_v1_article_path(id: 9999)

      json = JSON.parse(response.body, symbolize_names: true)
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'index' do
    it 'should render all articles correctly' do
      article1 = create(:article)
      article2 = create(:article)

      get api_v1_articles_path

      json = JSON.parse(response.body, symbolize_names: true)
      json.sort_by { |hash| hash[:data][:id] }

      pp json

      expect(response).to have_http_status(:ok)
      expect(json[:data][0][:title]).to eq(article1.title)
      expect(json[:data][0][:body]).to eq(article1.body)

      expect(json[:data][1][:title]).to eq(article2.title)
      expect(json[:data][1][:body]).to eq(article2.body)

      expect(json[:data].size).to eq(2)
    end
  end

end