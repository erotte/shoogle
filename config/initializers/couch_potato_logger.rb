# # https://gist.github.com/272912
# require 'singleton'
# unless Rails.env.test?
#   class Tracker
#     include Singleton
#     def add(runtime)
#       Thread.current[:couch_runtime] ||= 0
#       Thread.current[:couch_runtime] += runtime
#     end
# 
#     def reset_runtime
#       runtime = (Thread.current[:couch_runtime] || 0)
#       Thread.current[:couch_runtime] = nil
#       "DB: %.0f" % runtime
#     end
#   end
#   
# 
#   module CouchPotato
#     class Database
#       alias :view_without_benchmark :view
#       def view(spec)
#         result = nil
#         runtime = Benchmark.ms { result = view_without_benchmark(spec) }
#         log_entry = '[CouchPotato] view query: %s#%s (%.1fms)' % [spec.send(:klass).name, spec.view_name, runtime]
#         Rails.logger.debug(log_entry)
#         Tracker.instance.add(runtime)
#         result
#       end
#     end
# 
#     module ActionController
#       class Base
#         def perform_action
#           if logger
#             ms = [Benchmark.ms { perform_action_without_benchmark }, 0.01].max
#             logging_view = defined?(@view_runtime)
# 
#             log_message  = 'Completed in %.0fms' % ms
# 
#             if logging_view
#               log_message << " ("
#               log_message << view_runtime if logging_view
# 
#               log_message << ", " if logging_view
#               unless Rails.env.test?
#                 log_message << Tracker.instance.reset_runtime + ")"
#               end
#             end
# 
#             log_message << " | #{response.status}"
#             log_message << " [#{complete_request_uri rescue "unknown"}]"
# 
#             logger.info(log_message)
#             response.headers["X-Runtime"] = "%.0f" % ms
#           else
#             perform_action_without_benchmark
#           end
#         end  
#       end
#     end
#   end
# end