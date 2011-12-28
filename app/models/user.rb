# -*- encoding : utf-8 -*-
class User < ActiveRecord::Base
  attr_accessible :email, :username, :password, :password_confirmation, :providers_attributes
  
  has_many :providers, :class_name => 'UserProvider', :dependent => :destroy
  accepts_nested_attributes_for :providers
  
  authenticates_with_sorcery!
  
  validates_presence_of :email, :message => '이메일을 입력해 주세요.'
  validates_presence_of :gender, :message => '성별을 선택해 주세요.'
  validates_presence_of :age, :message => '나이를 선택해 주세요.'
  validates_presence_of :area, :message => '지역을 선택해 주세요.'
  validates_uniqueness_of :email, :unless => Proc.new {|user| user.external? }, :message => '이미 등록된 이메일입니다.'
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/, :message => '이메일 형식이 아닙니다.'
  validates_acceptance_of :term, :message => '이용약관에 동의해 주세요.'
  validates_acceptance_of :privacy, :message => '개인정보 수집 및 이용에 동의해 주세요.'
  validates_presence_of :password, :on => :create, :message => "비밀번호를 입력해 주세요."
  validates_length_of :password, :minimum => 3, :message => '비밀번호는 3자 이상 입력해 주세요.', :allow_blank => true
  validates_confirmation_of :password, :message => '비밀번호가 일치하지 않습니다.', :if => :password 
end
