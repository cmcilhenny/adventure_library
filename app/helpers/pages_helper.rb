module PagesHelper
  def linkify_page page
    #defines a regex, which helps make a fuzzy match...it is looking for format [[thing|thing]]
    regex = /\[\[([^|]+)\|(\w+)\]\]/
    #look at the text(text) of the page(page) and find all instances of regex to be substituted(gsub)
    page.text.gsub(regex) do |link|
      #create an array with two seperated pieces 
      caps = regex.match(link)
      #variable that searches database for the "linked_to_page" by looking up the name of the page
      linked_page = page.adventure.pages.find(:first, :conditions => ["lower(name) = ?", caps[2].downcase])
      #creating link with "link text" poining to the next page of the adventure. THe next page was found by looking it up by name and pulling the id from this param.
      link_to(caps[1], adventure_page_path(page.adventure_id, linked_page.id))
    end
  end
end

