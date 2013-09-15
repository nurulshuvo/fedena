
document.observe("dom:loaded", function() {
    $$('object').each(function(obj){
        a  = document.createElement('param');
        a.name = 'wmode';
        a.value = 'transparent';
        obj.appendChild(a);
    });

    load_menu_from_plugins();
});
