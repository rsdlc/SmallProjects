# def collect_with_max_id(collection=[], max_id=nil, &block)
#   response = yield(max_id)
#   collection += response
#   response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
# end

# # def CLIENT.get_all_tweets(user)
# #   collect_with_max_id do |max_id|
# #     options = {count: 200, include_rts: true}
# #     options[:max_id] = max_id unless max_id.nil?
# #     user_timeline(user, options)
# #   end
# # end
require 'sidekiq/api'

def job_is_complete(jid)
  # Revisa si la tarea se encuentra pendiente
  pending = Sidekiq::ScheduledSet.new
  return false if pending.find { |job| job.jid == jid }
  # Revisa si la tarea se encuentra en la cola 
  waiting = Sidekiq::Queue.new 
  return false if waiting.find { |job| job.jid == jid }
  # Revisa si la tarea se encuentra en proceso 
  working = Sidekiq::Workers.new
  return false if working.find { |worker, info| info["payload"]["jid"] == jid }
  # Si no se cumplió ninguna de las anteriores entonces la tarea ya fue procesada.  
  true
end