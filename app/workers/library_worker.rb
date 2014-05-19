class LibraryWorker
  include Sidekiq::Worker
  sidekiq_options :retry => false

  def perform(url)
     # 1. Send main site url to adventure worker
    AdventureWorker.perform_async(url)
     # 2. Get list of other libraries from url
     # 3. Loop through list and send each url to adventure worker

    library_response = Typhoeus.get("#{url}/libraries.json")
    if library_response.response_body == "" 
      return
    end
    parsed_library = JSON.parse(library_response.response_body)

    parsed_library["libraries"].each do |library|
      @url = library["url"]
      AdventureWorker.perform_async(@url)
    end
  end
end












