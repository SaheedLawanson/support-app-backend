class ChangeAttachmentsToBeArrayInSupportRequests < ActiveRecord::Migration[8.0]
  def change
    change_column :support_requests, :attachments, :string, array: true, default: [], using: 'ARRAY[attachments]'
  end
end
