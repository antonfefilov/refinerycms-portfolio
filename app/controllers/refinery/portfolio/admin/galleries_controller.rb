module Refinery
  module Portfolio
    module Admin
      class GalleriesController < ::Refinery::AdminController

        crudify :'refinery/portfolio/gallery',
                :order => 'lft ASC',
                :include => [:children],
                :paging => false

        def new
          @gallery = ::Refinery::Portfolio::Gallery.new(:parent_id => find_parent_gallery)
        end

        def children
          @gallery = find_gallery
          render :layout => false
        end

        protected

        def find_parent_gallery
          @parent_gallery = ::Refinery::Portfolio::Gallery.friendly.find(params[:parent_id]) if params[:parent_id].present?
        end

        def find_gallery
          @gallery = ::Refinery::Portfolio::Gallery.friendly.find(params[:id]) if params[:id].present?
        end

        private

        def gallery_params
          params.require(:gallery)
            .permit(:title, :body, :lft, :rgt, :position, :gallery_type, :depth, :parent_id, images: [])
        end
      end
    end
  end
end
