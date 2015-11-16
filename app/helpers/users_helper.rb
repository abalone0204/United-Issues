module UsersHelper
    def identity(user)
        if user.admin?
            "Admin"
        elsif user.editor?
            "小編"
        else 
            "一般使用者"
        end
        
    end
end
