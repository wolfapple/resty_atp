# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation, :providers_attributes
  
  has_many :providers, :class_name => 'UserProvider', :dependent => :destroy
  accepts_nested_attributes_for :providers
  
  authenticates_with_sorcery!
  
  validates_presence_of :email
  validates_uniqueness_of :email
  validates_length_of :password, :minimum => 3, :if => :password, :message => '비밀번호는 3자 이상 입력해 주세요.'
  validates_confirmation_of :password, :if => :password, :message => '비밀번호가 일치하지 않습니다.'
end
