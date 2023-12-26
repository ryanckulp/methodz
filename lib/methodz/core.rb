# frozen_string_literal: true

module Methodz
  class ActiveRecord::Base
    def methodz(opts = {})
      list = public_methods + private_methods + protected_methods - Object.methods
      return list if opts.empty?

      # simple usage, ex: user.methodz('stripe')
      opts = { q: opts } if opts.instance_of?(String)

      # query by keyword in definition
      list = list.filter { |m| m.to_s.include?(opts[:q] || '') }

      # query specific types, ex: user.methodz('stripe', type: 'private')
      if opts[:type] && !%w[all].include?(opts[:type])
        list = list.filter { |m| send("#{opts[:type]}_methods").include?(m) }
      end

      # remove ActiveModel::Dirty helpers, ex: will_save_change_to_{query}
      dirty_attrz.each { |da| list = list.filter { |m| !m.to_s.include?(da.to_s) } }
      list = list.filter { |_| dirty_attrz.any? { |da| !da.to_s.include?(opts[:q] || '') } }

      # remove getter/setter attributes (seeking user-defined methods, not activerecord given)
      attrz.each { |a| list = list.filter { |m| !m.to_s.include?(a.to_s) } }

      list
    end

    def attrz
      return [] unless respond_to?(:attributes)

      attributes.keys.map(&:to_sym)
    end

    # https://api.rubyonrails.org/classes/ActiveModel/Dirty.html
    def dirty_attrz
      %i[
        restore_ will_save_change_to _change_to_be_saved _for_database
        _before_last_save _in_database _change _was _id? _previously_was
        _before_last_save_was _came_from_ _before_type_cast _changed?
      ]
    end
  end
end
