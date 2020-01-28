require 'redmica_s3/attachment_patch'
require 'redmica_s3/attachments_controller_patch'
require 'redmica_s3/thumbnail_patch'
require 'redmica_s3/connection'

Redmine::Plugin.register :redmica_s3 do
  name 'RedMica S3 plugin'
  description 'Use Amazon S3 as a storage engine for attachments'
  url 'https://github.com/redmica/redmica_s3'
  author 'Far End Technologies Corporation'
  author_url 'https://www.farend.co.jp'

  version '1.0.0'
  requires_redmine version_or_higher: '4.1.0'

  Rails.configuration.to_prepare do
    Redmine::Thumbnail.__send__(:include, RedmicaS3::ThumbnailPatch)
    Attachment.__send__(:include, RedmicaS3::AttachmentPatch)
    AttachmentsController.__send__(:include, RedmicaS3::AttachmentsControllerPatch)
  end
  RedmicaS3::Connection.create_bucket
end
