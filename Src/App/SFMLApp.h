#ifndef SFMLAPP_H
#define SFMLAPP_H

#include <SFML/Graphics.hpp>

class SFMLApp
{
private:

    static SFMLApp* s_pInstance;

    sf::RenderWindow *m_pWindow;
    
public:

    SFMLApp();
    ~SFMLApp();

    static SFMLApp* Create();
    static SFMLApp* Get();
    static void Destroy();

    bool Init();
    void MainLoop();
};

#endif
