class ContactController < ApplicationController
  def index
    title = 'Contact Us - Wilson Investment Properties'
    description = 'Worried about financing in real estate investment? Feel free to contact us for help and buy residential and commercial properties in United State.'
    prepare_meta_tags(title: title, description: description,
                    twitter: {title: title, description: description},
                    og: {title: title, description: description}
                   )

  end
end