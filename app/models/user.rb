class User < ApplicationRecord
  has_many :authentications, :dependent => :destroy

  validates_presence_of :fullname
  validates_presence_of :email
  validates :password, presence: true, length: { in: 6..20 }
  validate :valid_email
  before_create :valid_email

  has_many :posts
  has_many :comments

  mount_uploader :avatar, AvatarUploader

  def self.create_with_auth_and_hash(authentication, auth_hash) create! do |u|
      u.first_name = auth_hash["info"]["first_name"]
      u.last_name = auth_hash["info"]["last_name"]
      u.email = auth_hash["info"]["email"]

      u.password = SecureRandom.hex(6)
      u.authentications<<(authentication)
    end
  end

  def fb_token
    x = self.authentications.where(:provider => :facebook).first
    return x.token unless x.nil?
  end

  filterrific(
    default_filter_params: { sorted_by: 'created_at_desc' },
    available_filters: [
      :sorted_by,
      :search_query,
    ]
  )

  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      # Simple sort on the created_at column.
      # Make sure to include the table name to avoid ambiguous column names.
      # Joining on other tables is quite common in Filterrific, and almost
      # every ActiveRecord table has a 'created_at' column.
      order("users.created_at #{ direction }")
    when /^name_/
      # Simple sort on the name colums
      order("LOWER(users.last_name) #{ direction }, LOWER(users.first_name) #{ direction }")
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }

  def self.options_for_sorted_by
    [
      ['Name (a-z)', 'name_asc'],
      ['Name (z-a)', 'name_desc'],
      ['Created at (desc)', 'created_at_desc'],
      ['Created at (asc)', 'created_at_asc'],
    ]
  end

  def name
    last_name + " " + first_name
  end

  scope :search_query, -> (search) { where("LOWER(fullname) LIKE ?", "%#{search.downcase}%") }
end
