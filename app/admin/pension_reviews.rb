# -*- encoding : utf-8 -*-
ActiveAdmin.register PensionReview do
  menu :label => '펜션 리뷰'
  
  index do
    column '작성자' do |review|
      review.user.email
    end
    column '펜션' do |review|
      review.pension.title
    end
    column '제목', :title
    column '총점', :overall
    column '투표', :helpful
    column '작성일', :created_at
    default_actions if current_admin_user.email
  end
end
