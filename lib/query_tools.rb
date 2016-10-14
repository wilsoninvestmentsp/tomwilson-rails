module QueryTools

    module_function

    def query params

    # limit = 100
    # start = 0

    # limit = params[:limit].to_i if params[:limit].present?

    # page = 1

    # page = params[:page].to_i if params[:page].present?

    # start = (page-1) * limit

    # q = ""


    # list = []
    # order = ""
    # params.each_with_index do |(key,val),i|

    #     new_val = ''

    #     multi = false

    #     if val.split(',').count > 1

    #         val.split(',').each_with_index do |item,z|

    #             new_val << ',' if z > 0
    #             new_val << "'#{item}'"

    #         end
    #         new_val = "(#{new_val})"
    #         multi = true

    #     else

    #         new_val = "#{val}"

    #     end

    #     if key.to_s.downcase == 'order'

    #         dir = 'ASC'
    #         dir = 'DESC' if new_val.to_s.downcase.include?('-')
    #         order = " ORDER BY #{new_val.gsub('-','')} #{dir}"

    #     end

    #   if !['action','controller','format','limit','page','order'].include?(key)

    #     type = 'AND'
    #     type = 'OR' if new_val[0] == '|'
    #     new_val.gsub!('|','')
    #     opp = '='
    #     opp = 'IN' if multi
    #     opp = '>' if new_val[0] == '>'
    #     opp = '<' if new_val[0] == '<'
    #     new_val.gsub!(/\>|\<|/,'') if opp == '>' || opp == '<'
    #     if new_val[0] == '*' || new_val[-1] == '*'
    #       new_val.gsub!('*','%')
    #       opp = 'LIKE'
    #     end
    #     list << " #{type} " if list.count > 0
    #     ex = "#{key} #{opp} '#{new_val}'"
    #     ex = "#{key} #{opp} #{new_val}" if opp == '>' || opp == '<' || key.include?('_id') || multi || ['true','false'].include?(new_val)
    #     list << ex

    #   end

    # end

    # q << list.join('')

    # q

    newParams = params.clone
    newParams.delete 'action'
    newParams.delete 'controller'
    newParams.delete 'format'
    newParams.delete 'limit'
    newParams.delete 'page'
    newParams.delete 'order'

    ors = []
    equals = [
        ['id','>',0,'id > 0']
    ]
    newParams.each do |key,val|

        opperator = '='

        if val.match /\A\|/i # OR's

            new_val = val.gsub /\A\|/i,''
            if new_val.match /\A\*|\*\z/i

                opperator = 'LIKE'
                new_val.gsub! /\A\*|\*\z/i,'%'

            elsif new_val.match /\A>=|<=|>|</i # > < >= <=

                scan = new_val.scan /\A>=|<=|>|</i
                scan.each do |s|

                    opperator = s if s.present?

                end

                new_val.gsub! /\A>=|<=|>|</i,''

            end

            new_val = "'#{new_val}'" if !opperator.match /\A>=|<=|>|<\z/i

            new_val = true if new_val.to_s.downcase == "'true'"
            new_val = false if new_val.to_s.downcase == "'false'"

            ors << [key,opperator,new_val,"#{key} #{opperator} #{new_val}"]

        else

            new_val = val

            if new_val.match /\A\*|\*\z/i

                opperator = 'LIKE'
                new_val = val.gsub /\A\*|\*\z/i,'%'

            elsif new_val.match /\A>=|<=|>|</i # > < >= <=

                scan = new_val.scan /\A>=|<=|>|</i
                scan.each do |s|

                    opperator = s if s.present?

                end

                new_val.gsub! /\A>=|<=|>|</i,''

            end

            if new_val.split(',').count > 1
                opperator = 'IN'
                new_val = '('+new_val.split(',').map { |item| "'#{item}'" }.join(',')+')'
            else
                new_val = "'#{new_val}'" if !opperator.match /\A>=|<=|>|<\z/i
            end

            new_val = true if new_val.to_s.downcase == "'true'"
            new_val = false if new_val.to_s.downcase == "'false'"

            equals << [key,opperator,new_val,"#{key} #{opperator} #{new_val}"]      

        end

    end

    query = equals.map { |item| item.last }.join(' AND ')
    query << ' AND ('+ors.map { |item| item.last }.join(' OR ')+')' if ors.count > 0
    query

  end

end