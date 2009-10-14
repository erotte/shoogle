module RailsSqlViews
  module ConnectionAdapters
    module SQLiteAdapter
      def supports_views?
        true
      end
      
      def tables(name = nil) #:nodoc:
        sql = <<-SQL
          SELECT name
          FROM sqlite_master
          WHERE (type = 'table' OR type = 'view') AND NOT name = 'sqlite_sequence'
        SQL

        execute(sql, name).map do |row|
          row[0]
        end
      end

      def base_tables(name = nil)
        sql = <<-SQL
          SELECT name
          FROM sqlite_master
          WHERE (type = 'table') AND NOT name = 'sqlite_sequence'
        SQL

        execute(sql, name).map do |row|
          row[0]
        end        
      end
      alias nonview_tables base_tables
      
      def views(name = nil)
        sql = <<-SQL
          SELECT name
          FROM sqlite_master
          WHERE type = 'view' AND NOT name = 'sqlite_sequence'
        SQL

        execute(sql, name).map do |row|
          row[0]
        end
      end
      
      # Get the view select statement for the specified table.
      def view_select_statement(view, name = nil)
        sql = <<-SQL
          SELECT sql
          FROM sqlite_master
          WHERE name = '#{view}' AND NOT name = 'sqlite_sequence'
        SQL
        
        view_sql = select_value(sql, name) or raise "No view called #{view} found"
        remove_create_view_prefix(view_sql)
      end
      
      def supports_view_columns_definition?
        false
      end
      
      def remove_create_view_prefix sql
        sql.gsub(/^CREATE *VIEW *"[^"]*" *AS */i,'')
      end
    end
  end
end
