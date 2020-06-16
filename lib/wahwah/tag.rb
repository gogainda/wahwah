# frozen_string_literal: true

module WahWah
  class Tag
    INTEGER_ATTRIBUTES = %i(disc disc_total track track_total)

    attr_reader(
      :title,
      :artist,
      :album,
      :albumartist,
      :composer,
      :comments,
      :track,
      :track_total,
      :genre,
      :year,
      :disc,
      :disc_total,
      :images,
      :duration,
      :bitrate,
      :sample_rate,
      :file_size
    )

    def initialize(file)
      if file.is_a?(IO) || file.is_a?(StringIO)
        @file_size = file.size
        @file_io = file
      else
        @file_size = File.size(file)
        @file_io = File.open(file)
      end

      @comments = []
      @images = []

      parse if @file_size > 0

      INTEGER_ATTRIBUTES.each do |attr_name|
        value = instance_variable_get("@#{attr_name}")&.to_i
        instance_variable_set("@#{attr_name}", value)
      end
    end

    def parse
      raise WahWahNotImplementedError, 'The parse method is not implemented'
    end
  end
end
