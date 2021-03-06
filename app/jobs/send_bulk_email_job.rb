class SendBulkEmailJob < ActiveJob::Base
  def perform(event_id)
    event = Event.find(event_id)
    BaseMailer.send_bulk_mail(to: Queries::UsersToEmailQuery.send(event.kind, event.eventable)) do |user|
      ThreadMailer.delay(priority: 2).send(event.kind, user, event)
    end
  end
end
