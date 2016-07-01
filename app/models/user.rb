class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :full_name, presence: { message: 'can\'t be empty' }

  has_many :events

  has_many :sent_messages,    foreign_key: 'sender_id',  class_name: 'Message'
  has_many :recived_messages, foreign_key: 'reciver_id', class_name: 'Message'
end
