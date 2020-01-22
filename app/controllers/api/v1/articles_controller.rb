# frozen_string_literal: true

module Api
  module V1
    class ArticlesController < ApplicationController
      def index
        @articles = Article.order('created_at DESC')

        render json: { status: 'SUCCESS', message: 'Loaded articles', data: @articles },
               status: :ok
      end

      def show
        @article = Article.find_by(id: params[:id])

        if @article
          render json: { status: 'Success', message: 'Loaded article from message', data: @article },
                 status: :ok
        else
          render json: { status: 'Not found!', message: 'Loaded article from message', data: @article },
                 status: :not_found
        end
      end

      def create
        @article = Article.new(article_params)

        if @article.save
          render json: { status: 'Success', message: 'Article saved', data: @article },
                 status: :ok
        else
          render json: { status: 'ERROR', message: 'Article not saved', data: @article.errors },
                 status: :unprocessable_entity
        end
      end

      def destroy
        @article = Article.find(params[:id])
        @article.destroy

        render json: { status: 'Success',
                       message: 'Deleted Article',
                       data: @article },
               status: :ok
      end

      def update
        @article = Article.find(params[:id])

        if @article.update(article_params)
          render json: { status: 'Success',
                         message: 'Article updated',
                         data: @article },
                 status: :ok
        else
          render json: { status: 'ERROR',
                         message: 'Article not updated',
                         data: @article.errors },
                 status: :unprocessable_entity
        end
      end

      private

      def article_params
        params.permit(:title, :body)
      end
    end
  end
end
