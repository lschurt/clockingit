# A user who is assigned to a task 
class TaskOwner < ActiveRecord::Base
  belongs_to :user
  belongs_to :task#, :touch => true

  named_scope :unread, :conditions => { :unread => true }

  # touch currently calls validations, which fail when creating from email, so update manually
  # see https://rails.lighthouseapp.com/projects/8994/tickets/2520-patch-activerecordtouch-without-validations
  after_save :touch_task

  private

  def touch_task
    self.task.update_attributes(:updated_at => Time.now) if self.task
  end

end
