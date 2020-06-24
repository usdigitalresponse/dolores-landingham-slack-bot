class SlackChannelIdFinder < SlackApiWrapper
  def run
    if slack_user_by_id
      slack_user_id = slack_user["id"]
      chat = client.conversations_open(users: slack_user_id)
      chat["channel"]["id"]
    end
  end
end
