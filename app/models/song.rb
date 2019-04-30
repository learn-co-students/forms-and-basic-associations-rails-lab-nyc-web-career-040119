class Song < ActiveRecord::Base
  belongs_to :artist
  belongs_to :genre
  has_many :notes

  # GENRE METHODS
  # using the same method as artist_name=
  def genre_name=(name)
    genre = Genre.find_or_create_by(name: name)
    self.genre = genre
    self.genre.save
  end

  def genre_name
    self.genre.name
  end

  # NOTES METHODS
  def note_contents=(notes)
    # notes is an array being passed through from song#new
    notes.each do |content|
      if content.strip != ""
        self.notes.new(content: content).save
        # self.notes.new == Note.new
        # .save can be chained to new instance to save it
        # cannot use .create unless parent is saved
        # in this case, parent == self (song)
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
