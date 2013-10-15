module Calendrier
  module CalendrierBuilder
    class CustomBuilder < Builder

      def render(header, content)
         # header is an array like this, having Date object of each columns
         # [Mon, 21 May 2012,
         #  Tue, 22 May 2012,
         #  Wed, 23 May 2012,
         #  Thu, 24 May 2012,
         #  Fri, 25 May 2012,
         #  Sat, 26 May 2012,
         #  Sun, 27 May 2012]
         # 
         # content is a double array like that, containing one Hash for each cell : {:time => Time.utc(<cell_begin_time>), :content => '<block content of this cell>' }
         # [ [ 7 Hash for one week ], [ 7 Hash for the next week ], ... ]
         #
         # [[{:time=>nil, :content=>nil}, # time could be nil on monthly display if week do not starts on monday/sunday (first day of week) 
         #   {:time=>2012-05-01 00:00:00 +0200, :content=>nil},
         #   {:time=>2012-05-02 00:00:00 +0200, :content=>nil},
         #   {:time=>2012-05-03 00:00:00 +0200, :content=>nil},
         #   {:time=>2012-05-04 00:00:00 +0200, :content=>nil},
         #   {:time=>2012-05-05 00:00:00 +0200, :content=>nil},
         #   {:time=>2012-05-06 00:00:00 +0200, :content=>nil}],
         #   ...
         # 
      end

    end
  end
end