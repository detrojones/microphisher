#
# microphisher - a spear phishing support tool
#
# Created by Ulisses Albuquerque & Joaquim Espinhara
# Copyright (C) 2013 Trustwave Holdings, Inc.
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#

class UnknownSubject
  include Mongoid::Document
  
  # Attribute listing
  field :name, type: String
  field :description, type: String
  
  # Validations
  validates :name, presence: true
  
  # Relations
  belongs_to :user
  has_many :data_sources
  has_many :profiles
  
  def profile_image_url
  	if data_sources.count > 0
  		data_sources.first.profile_image_url
  	else
  		'/default_profile_image.png'
  	end
  end
  
  def status_updates
  	StatusUpdate.in(data_source_id: data_sources.pluck(:id))
  end
end
