class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  # GENRE METHODS

  # NOTES METHODS
  def note_contents=(notes)
    # notes is an array being passed through from song#new
    notes.each do |content|
      if content.strip != ""
        # if content is not an empty string, create a new note and assign to current song
        Note.create(content: content, song: self)
      end
    end
  end

  def note_contents
    # rspec is asking for an array of the song notes
    self.notes.map { |note| note.content }

  end

  # ARTIST METHODS
  def artist_name=(name)
    artist = Artist.find_or_create_by(name: name)
    self.artist = artist
    # after updating, it needs to be saved to be committed to database
    self.artist.save
  end

  def artist_name
    # this will throw an error if self.artist.name doesn't exist
    if self.artist
      self.artist.name
    else
      nil
    end
  end
end
