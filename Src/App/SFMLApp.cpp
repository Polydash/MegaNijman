#include <cstdlib>
#include <cassert>

#include "SFMLApp.h"
#include "../Macros/Allocation.h"

SFMLApp* SFMLApp::s_pInstance = NULL;

SFMLApp::SFMLApp():
m_pWindow(NULL)
{
}

SFMLApp::~SFMLApp()
{
    SAFE_DELETE(m_pWindow);
}

SFMLApp *SFMLApp::Create()
{
    if(!s_pInstance)
    {
        s_pInstance = new SFMLApp;
    }

    return s_pInstance;
}

SFMLApp *SFMLApp::Get()
{
    if(!s_pInstance)
    {
        return Create();
    }

    return s_pInstance;
}

void SFMLApp::Destroy()
{
    SAFE_DELETE(s_pInstance);
}

bool SFMLApp::Init()
{
    m_pWindow = new sf::RenderWindow(sf::VideoMode(800, 600), "MegaNijman");
    if(!m_pWindow)
    {
        return false;
    }
    
    m_pWindow->setVerticalSyncEnabled(true);
    
    return true;
}

void SFMLApp::MainLoop()
{
    assert(m_pWindow);

    sf::Event evt;
    sf::Clock clock;

    while(m_pWindow->isOpen())
    {
        sf::Time elapsed = clock.getElapsedTime();
        clock.restart();
        
        while(m_pWindow->pollEvent(evt))
        {
            if(evt.type == sf::Event::Closed)
            {
                m_pWindow->close();
            }
        }

        m_pWindow->clear();
        //Graphics here
        m_pWindow->display();
    }
}
