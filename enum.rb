dynasty_members = ['bayler', 'ben', 'austin', 'justyn', 'brodie', 'jon', 'kadeem', 'kendra']
dynasty_admin = []

dynasty_members.each {|member| dynasty_admin.push(member.upcase)}
puts dynasty_admin

puts dynasty_members.map{|member| member.upcase}



puts dynasty_admin
dynasty_admin.map! {|member| member.downcase}
puts dynasty_admin