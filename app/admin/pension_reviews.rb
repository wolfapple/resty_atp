# -*- encoding : utf-8 -*-
ActiveAdmin.register PensionReview do
  menu :label => '펜션 리뷰'
  
  index do
    column '작성자' do |review|
      review.user.email
    end
    column '제목', :title
    column '총점', :overall
    column '청결도', :clean
    column '친절도', :kindness
    column '가격만족도', :price
    column '위치접근성', :location
    column '인테리어', :interior
    column '투표', :helpful
    column '작성일', :created_at
    default_actions if current_admin_user.email
  end
end
