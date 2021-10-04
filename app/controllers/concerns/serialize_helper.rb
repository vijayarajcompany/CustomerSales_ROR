class SerializeHelper
  def self.pagination_dict(collection)
    {
      current_page: collection.current_page,
      next_page: collection.next_page,
      prev_page: collection.previous_page,
      total_pages: collection.total_pages,
      total_count: collection.total_entries
    } if collection.present?
  end

  def self.invitation_by_status(collection)
    {
      invitation_accepted: collection.accepted.count,
      invitation_pendings: collection.pending.count,
      invitation_canceled: collection.request_cancelled.count,
    }
  end

  def self.invitation_status_policy(collection, users, policy, company_id)
    {
      invitation_accepted: collection.accepted.count,
      invitation_pendings: collection.pending.count,
      invitation_yet_to_invite:  User.where("id NOT IN (SELECT DISTINCT(user_id) FROM policy_acceptances WHERE policy_id = ?) AND company_id = ?", policy.id, company_id).count
    }
  end

  def self.complience_options
    {
      applicable: ['Yes', 'No'],
      request_help: ['Yes', 'No'],
      policy_defines: PolicyDefine.all.as_json(:only => [:id, :name]),
      control_implements: ControlImplement.all.as_json(:only => [:id, :name]),
      control_reports: ControlReport.all.as_json(:only => [:id, :name]),
      control_automats: ControlAutomat.all.as_json(:only => [:id, :name])
    }
  end

  def self.policy_status(collection)
    {
      pending: collection.pending.count,
      accepted: collection.accepted.count
    }
  end
end
