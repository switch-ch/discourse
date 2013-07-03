class AaiUserInfo < ActiveRecord::Base
  belongs_to :user
end

# == Schema Information
#
# Table name: aai_user_infos
#
#  id               :integer          not null, primary key
#  user_id          :integer          not null
#  unique_id        :string(255)      not null
#  persistent_id    :text             not null
#  username         :string(255)      not null
#  given_name       :string(255)
#  surname          :string(255)
#  email            :string(255)
#  home_organization :string(255)
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
# Indexes
#
#  index_aai_user_infos_on_unique_id  (unique_id) UNIQUE
#  index_aai_user_infos_on_user_id    (user_id) UNIQUE
#

