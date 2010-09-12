require File.expand_path(File.dirname(__FILE__) + '/affilinet_row_handler')


FILE_NAME = "data/affilinet_products_1118_535368.csv"
CONFIG = {  :col_sep => ";", 
            :headers => true, 
            :header_converters => :symbol,
            :skip_blanks => true}

class Affilinet

  def import
    clean
    import_file
    trigger_view_rebuild
  end
  
  def clean
    start = Time.now
    puts "deleting all Affiliate Shoes.."
    AffiliateShoe.delete_all
    putsDone start
  end
  
  def import_file
    start = Time.now
    handler = AffilinetRowHandler.new
    row_index = 1
    puts "starting import.."
    FasterCSV.foreach(FILE_NAME,CONFIG) do |row|
      row_index += 1
      puts "imported #{row_index}" if row_index % 100 == 0
      begin
        doc = handler.handle(row)
      rescue
        puts "\ncould not import row:"+row_index
        puts "\nrow:\n#{row.inspect}\n"
      end
      CouchPotato.database.save doc if doc
    end
    putsDone start
  end
  
  def trigger_view_rebuild
    start = Time.now
    puts "rebuilding search index.."
    CouchPotato.database.view(AffiliateShoe.by_words_of_name(:limit => 1))
    putsDone
  end
  
  def putsDone start
    puts ".. done (#{Time.now - start} sek)"
  end
end
